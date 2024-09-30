import * as cdk from 'aws-cdk-lib';
import { CodeBuildStep, CodePipeline, CodePipelineSource, ShellStep } from 'aws-cdk-lib/pipelines';
import { Construct } from 'constructs';
import { pipelineStage } from './pipeline-stage';


export class CdkCicdStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const myPipeline = new CodePipeline(this, 'myFirstPipeline', {
      pipelineName: 'myFirstPipeline',
      synth: new ShellStep('Synth', {
        input: CodePipelineSource.gitHub('nbudemy/cdk-cicd', 'cicd-practice'),
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
  }
}