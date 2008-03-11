From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Can't mount shares ending in $
Date: Tue, 11 Mar 2008 11:06:46 +1100
Message-ID: <47D5CD16.5000807@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Debug files available at http://www.mmcit.co.nz/debug.zip

I recently (about a month ago) upgraded to Fedora 8 (previously on

Fedora 6).

Autofs mounting of shares ending in $ worked on FC6. I think this is the 
first time I've tried since on Fedora 8.
I've got another Fedora 6 box and shares ending in $ still work ok on 
this box.

I've tried playing around with the auto.samba script I use but no luck.
Output from it is:

RUN:  auto.samba matthew
-fstype=cifs,username=mjurgens,password=parallel12 \
         /cd "://matthew/cd" \
         /C "://matthew/C" \
         /G\$ "://matthew/G\$" \
         /E "://matthew/E" \
         /G "://matthew/G" \
         /ADMIN\$ "://matthew/ADMIN\$" \
         /C\$ "://matthew/C\$"
(This is the exact same result as the Fedora6 box)

 From the debug info, the mount command that fails is:
mount -t cifs -s -o username=USER,password=PASSWORD //matthew/C\$ /smb/matthew/C$
This works manually if I:
mount -t cifs -s -o username=USER,password=PASSWORD //matthew/C\$ /mnt/matthew
The other share to the same location works fine through autofs:
mount -t cifs -s -o username=USER,password=PASSWORD //matthew/C /smb/matthew/C


Autofs Version = autofs-5.0.2-27
uname -r = 2.6.22.14-72.fc6PAE (I know its an FC6 kernel, everything 
else is FC8 and I've been running on this since the upgrade due to a 
problem with either mkintrd or nash)

Reference to an earlier problem with a fix to shares ending in $ where I 
got the map from:
http://www.mail-archive.com/autofs@linux.kernel.org/msg05691.html
