using Newtonsoft.Json;
using RestSharp;

namespace K8MsTest
{
    [TestClass]
    public class KubernetesTest
    {
        [TestMethod]
        public void TestBackEnd()
        {
            string backendUrl = "http://backend-service:3000";
            var client = new RestClient(backendUrl);
            var request = new RestRequest("/greet", Method.Get);
            var response = client.Execute(request);
            Assert.AreEqual((int)response.StatusCode, 200, "Expected status code 200.");
            var jsonResponse = JsonConvert.DeserializeObject<Dictionary<string, string>>(response.Content);
            Assert.IsNotNull(jsonResponse, "There is no json response");
            string actualMsg = jsonResponse["message"];
            string expectedMsg = "Hello from the Backend!";
            Assert.AreEqual(actualMsg, expectedMsg, "The backend did not return the expected message.");
        }
        [TestMethod]
        public void TestFrontEnd()
        {
            string frontendUrl = "http://frontend-service:80";
            var client = new RestClient(frontendUrl);
            var request = new RestRequest("", Method.Get);
            var response = client.Execute(request);
            Assert.AreEqual((int)response.StatusCode, 200, "Expected status code 200.");
            var responseTxt = response.Content;
            //string actualMsg = jsonResponse["message"];
            string expectedMsg = "Hello from the Backend!";
            Assert.IsTrue(responseTxt.Contains(expectedMsg), "The backend did not return the expected message.");
        }
    }
}