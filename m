From: Ian Kent <raven@themaw.net>
Subject: Re: Proposed update to auto.smb
Date: Mon, 03 Nov 2008 12:05:04 +0900
Message-ID: <1225681504.2911.41.camel@zeus.themaw.net>
References: <1225679565.2911.31.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1225679565.2911.31.camel@zeus.themaw.net>
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

On Mon, 2008-11-03 at 11:32 +0900, Ian Kent wrote:
> Hi all,
> 
> Stef Bon has reported some difficulty with the current auto.smb.
> 
> I have made a patch which demonstrates the change he is recommending and
> would like comments from others that use CIFS mounts.
> 
> To quote Stef, from his previous mail:
> 
> "Well, the script does (in my network) work with cifs shares, where the
> original auto.smb doesn't. In my case I have to add the ipaddress or it
> does not work. The manpage of mount.cifs says that this option has to be
> used rarely. But it's my experience sometimes when mounting a Win2K or
> WinXP machine, it does not work.
> (CIFS expects the tcp name and not the netbiosname, smbfs did that)
> 
> So I cannot say it's a really "must", but at least it cannot "hurt".
> You're on the safe side when using the ipaddress."
> 
> Can we have some comments on the patch below please (including you Stef,
> since I've modified you change a bit).
> 
> Ian

Sorry, the patch was not quite right.

autofs-5.0.3 - CIFS use ip address

From: Stef Bon <stef@bononline.nl>

It has been reported that, for a CIFS mount, in some cases the ip
address of the server is needed otherwise the mount can fail.
---

 samples/auto.smb |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)


diff --git a/samples/auto.smb b/samples/auto.smb
index fb39053..7bec126 100755
--- a/samples/auto.smb
+++ b/samples/auto.smb
@@ -3,7 +3,31 @@
 # This file must be executable to work! chmod 755!
 
 key="$1"
-opts="-fstype=cifs"
+
+FILESYSTEM="cifs"
+
+if [ "$FILESYSTEM" != "cifs" ]; then
+	opts="-fstype=$FILESYSTEM,guest"
+else
+	for P in /bin /sbin /usr/bin /usr/sbin
+	do
+		if [ -x $P/nmblookup ]; then
+			NMBLOOKUP=$P/nmblookup
+			break
+		fi
+	done
+
+	if [ ! -x "$NMBLOOKUP" ]; then
+		exit 1
+	fi
+
+	ipaddress=$($NMBLOOKUP $key --debug-level=0 2>>/dev/null | grep '<00>' | awk '{ print $1 }')
+	if [ -z "$ipaddress" ]; then
+		exit 1
+	fi
+
+	opts="-fstype=cifs,guest,ip=$ipaddress"
+fi
 
 for P in /bin /sbin /usr/bin /usr/sbin
 do
