From: Fajar Priyanto <fajarpri@cbn.net.id>
Subject: Re: SOLVED?? Pls help on configuring autofs on NFS for
	home dir
Date: Tue, 26 Sep 2006 11:43:12 +0700
Message-ID: <200609261143.12477.fajarpri@cbn.net.id>
References: <200609261119.47084.fajarpri@cbn.net.id>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200609261119.47084.fajarpri@cbn.net.id>
Content-Disposition: inline
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

On Tuesday 26 September 2006 11:19, Fajar Priyanto wrote:
> Hi all,
> I'm trying to setup this scenario on NFS and autofs on Centos 4.3:
> - useradd nfstest on an NFS server (192.168.1.247)
> - Setting up this NFS server /etc/exports:
> /home/nfstest   192.168.1.252/255.255.255.0(rw,sync,no_root_squash)
>
> - useradd nfstest on a client machine (192.168.1.252)
> - make sure that the uid and gid are the same on the server and the client
> - setting up /etc/auto.master:
> /home/nfstest   /etc/auto.nfs   --timeout=60
> - setting up /etc/auto.nfs:
> * -rw,soft,intr 192.168.1.247:/home/&
>
> - Restarting portmap, nfs, nfslock on the server
> - Restarting autofs on the client
>
> - showmount -e localhost:
> /home/nfstest 192.168.1.252/255.255.255.0
>
> - Try to logon using username on the client: nfstest
>
> But I've got this error:
>
> automount[5937]: >> mount: 192.168.1.247:/home/.bash_profile failed, reason
> given by server: Permission denied
> automount[5937]: mount(nfs): nfs: mount failure
> 192.168.1.247:/home/.bash_profile on /home/nfstest/.bash_profile
> automount[5937]: failed to mount /home/nfstest/.bash_profile
> automount[5939]: >> mount: 192.168.1.247:/home/.bash_login failed, reason
> given by server: Permission denied
> automount[5939]: mount(nfs): nfs: mount failure
> 192.168.1.247:/home/.bash_login on /home/nfstest/.bash_login
> automount[5939]: failed to mount /home/nfstest/.bash_login
> automount[5941]: >> mount: 192.168.1.247:/home/.profile failed, reason
> given by server: Permission denied
>
> And on the login screen shows only this:
> -bash-3.00$
>
> Oh by the way, firewall is off.
>
> But, when I did 'cd nfstest' it mount the directory!
> Also as root, if I do 'cd /home/nfstest/nfstest' it mount the directory.
>
> Is that the correct way? I mean why I need to 'cd' thing?
> Am I missing something?
> Thank you very much,

After a second thought...
I modify this:
/etc/exports:
/home   192.168.1.252/255.255.255.0(rw,sync,no_root_squash)

/etc/auto.master:
/mnt    /etc/auto.nfs   --timeout=60    -fstype=nfs

/etc/auto.nfs:
*       -rw,soft,intr   192.168.1.247:/home/&

And finally, I also modify the home directory of user: nfstest in /etc/passwd 
file from /home/nfstest to /mnt/nfstest

Try logon as nfstest, and... voila!! It works!!
Is this the correct way? Especially do I need to modify the home directory of 
the user in /etc/passwd?

Thank you very much.
-- 
Fajar Priyanto | Reg'd Linux User #327841 | Linux tutorial 
http://linux2.arinet.org
11:42am up 2:55, 2.6.16.13-4-default GNU/Linux 
Let's use OpenOffice. http://www.openoffice.org
