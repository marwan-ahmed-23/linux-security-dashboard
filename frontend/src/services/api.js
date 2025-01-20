import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:5000/api', 
});

// You can add an interceptor to handle the token or other headers
// api.interceptors.request.use(config => {
//   // Example: reading the token from localStorage
//   const token = localStorage.getItem('token');
//   if (token) {
//     config.headers.Authorization = `Bearer ${token}`;
//   }
//   return config;
// });

export default api;
