const tokenKey = 'APP_TOKEN';
const getStartedKey = 'GET_STARTED';
const roleKey = "ROLE";
const userKey = "USER";
const allIssuesKey = "ALL-ISSUES";
const myIssuesKey = "MY-ISSUES";
const likedIssuesKey = "LIKED-ISSUES";
const serviceInItKey = "SERVICE_INIT";

// prod
const baseUrl = "https://reportit.as3hr.dev/api";
String socketUrl(int id) => "ws://reportit.as3hr.dev/ws/comments/$id/";

// dev
// const baseUrl = 'http://192.168.1.105:8000/api';
// String socketUrl(int id) => "ws://192.168.1.105:8000/ws/comments/$id/";
