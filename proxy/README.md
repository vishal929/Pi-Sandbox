## http proxy

We are using a squid forward http proxy from the agent to the internet to prevent any requests to unwanted domains. 

The sandbox will forward requests to the squid http proxy first. Error codes and messages about the proxy are below. The messages to return are important to give context to the agent. 

- Request is not HTTPS
    - Error code 403 Method not allowed
    - Message: "Requests must use SSL for secure communication." 
- Request is to a domain not on the allowlist
    - Error code 403 Forbidden
    - Message: "The agent is not authorized to access this domain. Please check allow list."