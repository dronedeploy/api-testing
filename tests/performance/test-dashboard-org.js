import { check, sleep } from "k6";
import http  from "k6/http";

const _CREDENTIALS = `DroneDeploy:${__ENV.PIPELINE_KEY}`
const _ORG_ID = "5eebf38d6f2fc3d1c0f5e4ab";  // At time of writing, org has 5094 folders on stage.

export const options = {
  duration: '1m',
  thresholds: {
    http_req_duration: ["p(95)<500"],  // 95% of requests must complete below 0.5s
  },
  vus: 20,
};

export default function() {
    const response = http.get(
        `https://${_CREDENTIALS}@stage.dronedeploy.com/api/v1/folders?organization_id=${_ORG_ID}`,
        { auth: "basic" }
    );
    check(response, {
      "status is 200": (r) => r.status === 200,
    });
    sleep(3);
}
