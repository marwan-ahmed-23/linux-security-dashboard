const API_BASE_URL = "http://localhost:5000"; 

async function fetchSystemInfo() {
  try {
    const response = await fetch(`${API_BASE_URL}/api/system-info`);
    const data = await response.json();
    const systemInfoList = document.getElementById("system-info-list");
    
    systemInfoList.innerHTML = "";
    
    for (let key in data) {
      const li = document.createElement("li");
      li.className = "list-group-item";
      li.textContent = `${key}: ${data[key]}`;
      systemInfoList.appendChild(li);
    }
  } catch (error) {
    console.error("Error fetching system info:", error);
  }
}

async function fetchOpenPorts() {
  try {
    const response = await fetch(`${API_BASE_URL}/api/open-ports`);
    const data = await response.json();
    const openPortsList = document.getElementById("open-ports-list");

    openPortsList.innerHTML = "";

    if (Array.isArray(data)) {
      data.forEach(port => {
        const li = document.createElement("li");
        li.className = "list-group-item";
        li.textContent = `${port.protocol} - ${port.address}`;
        openPortsList.appendChild(li);
      });
    } else if (data.error) {
      openPortsList.innerHTML = `<li class="list-group-item text-danger">${data.error}</li>`;
    }
  } catch (error) {
    console.error("Error fetching open ports:", error);
  }
}

async function fetchProcesses() {
  try {
    const response = await fetch(`${API_BASE_URL}/api/processes`);
    const data = await response.json();
    const processesTableBody = document.querySelector("#processes-table tbody");

    processesTableBody.innerHTML = "";

    if (Array.isArray(data)) {
      data.forEach(proc => {
        let tr = document.createElement("tr");
        tr.innerHTML = `
          <td>${proc.pid}</td>
          <td>${proc.user}</td>
          <td>${proc.cpu_usage}</td>
          <td>${proc.mem_usage}</td>
          <td>${proc.command}</td>
        `;
        processesTableBody.appendChild(tr);
      });
    } else if (data.error) {
      let tr = document.createElement("tr");
      tr.innerHTML = `<td colspan="5" class="text-danger">${data.error}</td>`;
      processesTableBody.appendChild(tr);
    }
  } catch (error) {
    console.error("Error fetching processes:", error);
  }
}

async function fetchFailedLogins() {
  try {
    const response = await fetch(`${API_BASE_URL}/api/failed-logins`);
    const data = await response.json();
    const failedLoginsList = document.getElementById("failed-logins-list");

    failedLoginsList.innerHTML = "";

    if (Array.isArray(data)) {
      data.forEach(failed => {
        const li = document.createElement("li");
        li.className = "list-group-item";
        li.textContent = failed;
        failedLoginsList.appendChild(li);
      });
    } else if (data.error) {
      failedLoginsList.innerHTML = `<li class="list-group-item text-danger">${data.error}</li>`;
    }
  } catch (error) {
    console.error("Error fetching failed logins:", error);
  }
}

window.addEventListener("DOMContentLoaded", () => {
  fetchSystemInfo();
  fetchOpenPorts();
  fetchProcesses();
  fetchFailedLogins();
});
