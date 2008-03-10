From: Matthew Jurgens <mjurgens@edcint.co.nz>
Subject: Can't mount shares ending in $.
Date: Tue, 11 Mar 2008 10:35:26 +1100
Message-ID: <47D5C5BE.9030306@edcint.co.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010900090705030704030601"
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

This is a multi-part message in MIME format.
--------------010900090705030704030601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

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


Debug Info attached.
Autofs Version = autofs-5.0.2-27
uname -r = 2.6.22.14-72.fc6PAE (I know its an FC6 kernel, everything 
else is FC8 and I've been running on this since the upgrade due to a 
problem with either mkintrd or nash)

Reference to an earlier problem with a fix to shares ending in $ where I 
got the map from:
http://www.mail-archive.com/autofs@linux.kernel.org/msg05691.html








--------------010900090705030704030601
Content-Type: application/x-zip-compressed;
 name="debug.zip"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="debug.zip"

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
UAEAAOQSAAAAAA==
--------------010900090705030704030601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------010900090705030704030601--

