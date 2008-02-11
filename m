From: Stef Bon <stef@bononline.nl>
Subject: User token activating the mount.
Date: Mon, 11 Feb 2008 14:49:42 +0100
Message-ID: <47B05276.6080800@bononline.nl>
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

Hello,

some time I've been experimenting with the automounter to mount smb
shares for ordinary
users.

I've got autofs-5.0.3 installed with patches for my linux-2.6.23.11 kernel.

My auto.master looks like:

/mnt/autofs/network    /etc/auto.network

and /etc/auto.network is:

* -fstype=network :/&%$USER

I've read that in construction of the key some variables are possible.
So this auto.network adds the username
to the key, seperated with a %.

Now with this construction the mount wrapper mount.network is called.
Basically it analyses
the key and constructs the real unc_address out of it. My construction
uses mountpoints like:


/home/sbon/Global Network/Windows Network/WORKGROUP/SERVER/firstshare ->

    /mnt/autofs/network/smb:%%u_sbon@SERVER@WORKGROUP%firstshare

Note this is a single directory, containing several "fields":
- smb is the protocol
- u_sbon is the indicator that the mount should be done as the normal
user sbon
- SERVER and WORKGROUP speak for themselves
- firstshare is the share on SERVER

Now, the mount.network wrapper contruct out of this:

mount.cifs //SERVER/firstshare
/mnt/autofs/network/smb:%%u_sbon@SERVER@WORKGROUP%firstshare -o
credentials=/home/sbon/.autofssession/smb/mount.cred

I can add an extra command to log the environment with:

set >> /var/log/mount.network.log

I do not do this because I hope the environment variable USER will be
the user which activated the automounter,
but I can look at the arguments the script mount.network gets. And look:

cat /var/log/mount.network.log | grep ^BASH_ARGV

and look at the last added line1, and then to the argument corresponding
with the key ( or extern address):

a %root is added to this key when I do a ls (as root):

ls -al /mnt/autofs/network/smb:%%u_sbon@SERVER@WORKGROUP%public

the automounter has added the user (which is now root) to the key:

[3]="/smb:%%u_son@SERVER@WORKGROUP%public%root"

Now this happens also, when I do this as myself (sbon).
The only thing is that it does not always does this. Sometimes this
field is empty. I'm still testing.

So good news! With this extra field indicating the user which is
activating the mount, it is possible
to do an extra security check. An mount on behalf of an user can only be
activated by himself. And everybody
can do a guest mount.

Stef Bon
