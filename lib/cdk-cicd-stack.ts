import * as cdk from 'aws-cdk-lib';
import * as codebuild from 'aws-cdk-lib/aws-codebuild';
import * as secretsmanager from 'aws-cdk-lib/aws-secretsmanager';
import { CodeBuildStep, CodePipeline, CodePipelineSource, ShellStep } from 'aws-cdk-lib/pipelines';
import { Construct } from 'constructs';
import { pipelineStage } from './pipeline-stage';
import { LinuxBuildImage } from 'aws-cdk-lib/aws-codebuild';



export class CdkCicdStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const myPipeline = new CodePipeline(this, 'myFirstPipeline', {
      pipelineName: 'myFirstPipeline',
      synth: new ShellStep('Synth', {
        input: CodePipelineSource.gitHub('nbudemy/cdk-cicd', 'cicd-practice',  {
          authentication: cdk.SecretValue.secretsManager('github-pa-token', { jsonField: 'Token'})
        }),
        commands: [
          'npm install',
          'npx cdk synth'
        ]
      })
    });

    const testStage = myPipeline.addStage(new pipelineStage(this, 'PipelineTestStage', {
      stageName: 'test'
    }));

    testStage.addPre(new CodeBuildStep('unit tests', {
      commands: [
        'npm install',
        'npm test'
      ]
    }))

    const liquibaseProject = new codebuild.Project(this, 'LiquibaseProject', {
      environment: {
          buildImage: LinuxBuildImage.fromDockerRegistry('liquibase/liquibase:4.29.2'),
      },
      environmentVariables: {
        LIQUIBASE_CLASSPATH: {
          type: codebuild.BuildEnvironmentVariableType.PLAINTEXT,
          value: '/liquibase/lib/mysql-connector-java-8.0.30.jar'
        },
        LIQUIBASE_COMMAND_USERNAME: {
          type: codebuild.BuildEnvironmentVariableType.PLAINTEXT,
          value: 'admin'
        },
        LIQUIBASE_COMMAND_CHANGELOG_FILE: {
          type: codebuild.BuildEnvironmentVariableType.PLAINTEXT,
          value: 'db-changelog.xml'
        },
        LIQUIBASE_COMMAND_URL: {
          type: codebuild.BuildEnvironmentVariableType.PLAINTEXT,
          value: 'jdbc:mysql://database-1-instance-1.cp0sm0qwq4ri.eu-west-1.rds.amazonaws.com/soccer_data'
        }
      },
      buildSpec: codebuild.BuildSpec.fromObject({
        version: '0.2',
        env: {
          "secrets-manager": {
            "DB_PASSWORD": "rds!cluster-3b3e919d-6c30-412c-9f05-bd7be8b0acda:password" 
          }
        },
        phases: {
          build: {
            commands: [
              'cd db',
              'lpm add mysql --global',
              'liquibase --password=$DB_PASSWORD update --log-level=DEBUG'
            ]
          }
        }
      })
    });
  }
}