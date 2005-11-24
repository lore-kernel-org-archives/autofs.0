From: Prakash Velayutham <prakash.velayutham@cchmc.org>
Subject: autofs-4.1.3 not working properly
Date: Thu, 24 Nov 2005 14:28:38 -0500
Message-ID: <43861466.2030706@cchmc.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hi,

I am new to this list, so please forgive my ignorances.
I had a SuSE Pro 9.0 system running autofs (v3) running earlier. The 
autofs itself did not have any issues at all until I decided to upgrade 
the system to SuSE 9.3. It was a clean install, and autofs4-4.1.3 became 
the default kernel autofs module. My autofs master map comes from a 
OpenLDAP server and it contains 3 different mount maps.
/users (LDAP map)
/protein/users (LDAP map)
/import/users (LDAP map)
I also have a file-based map in this server (/export/users).

Recently I was trying to move a user's home dir from server1 to server2. 
After moving his home dir and making the relevant changes to his LDAP 
entry (homeDirectory attribute), I tried to restart autofs in the 
above-mentioned server. The server already had several users logged in 
under /protein/users. Though the restart did not complain, I noticed 
that autofs status showed "Configured mount points" correctly and 
removed the currently mounted mount points from "Active mount points". 
Is there a reason why? Also strangely the ownerships of the previously 
mounted dirs had been changed to root:root.

I have been forced to move back to autofs-3.1.7-904 as this is a 
production server. Any help much appreciated.

Thanks,
Prakash
