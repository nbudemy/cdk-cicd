import { handler } from "../services/hello";


describe("Hello Lambda Test suite", ()=>{
    test('Handler test 200 response?', async () => {
        const result = await handler({}, {});
        expect(result.statusCode).toBe(200);
    });
});

