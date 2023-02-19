<H1>WireGuard VPN Server Setup Script</H1>

This is a bash script that will setup a WireGuard VPN on a Debian based Linux server, as easily as possible!

This script automates the setup of a WireGuard VPN server on Debian based Linux. It generates public and private keys for the server and client, creates the WireGuard configuration file, sets Google DNS servers, enables IP forwarding and Masquerade, and sets the WireGuard interface IP address.

<H2>Requirements</H2>
<li>A Linux machine running Ubuntu, Debian, or CentOS.</li>
<li>Sudo privileges on the Linux machine.</li>
<li>Internet access to download and install the WireGuard package.</li>

<H2>Installation</H2>
Download the script:

<pre><code>wget https://raw.githubusercontent.com/HessamAyoubi/Easy_WireGuard/5a018ea91450945dbe64d41df7268eacdd632a95/wireguard-setup.sh</code></pre>

Make the script executable:

<pre><code>chmod +x wireguard-setup.sh</code></pre>

Run the script with sudo privileges:

<pre><code>sudo ./wireguard-setup.sh</code></pre>

Follow the on-screen prompts to configure your WireGuard server.

<H2>Configuration</H2><p>You cany modify them by changing the script</p>

Server address: The IP address or hostname of your server (The script will prompt you for this information)</br>
Server port: 51820</br>
Client IP range: 10.1.1.0/24</br>
DNS server: 8.8.8.8</br>

The script will generate a server configuration file (wg0.conf) in the /etc/wireguard/ directory based on the information you provide.</br>
It will also generate client.config for the client.

<H2>Troubleshooting</H2>
<li>If you can't access the Internet or ping any public IP after connecting with WireGuard, check the firewall settings on your server and client devices.</li>

<li>If you can't see the WireGuard tunnel interface on the server after running the script and the VPN doesn't work, check the configuration file at <code>/etc/wireguard/wg0.conf</code></li>

<li>If the WireGuard service is inactive and you get an error like <code>"/usr/bin/wg-quick: line 32: resolvconf: command not found"</code>, install the resolvconf package:

<pre><code>sudo apt-get install resolvconf</code></pre></li>
