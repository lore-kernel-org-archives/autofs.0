From: Gerd Bavendiek <gerd.bavendiek@googlemail.com>
Subject: autofs4 with NetApp-Filer and large export list: Stopped
 working for me
Date: Fri, 27 Apr 2007 14:33:24 +0200
Message-ID: <4631ED94.70900@googlemail.com>
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

Hi,

I used to use autofs4 with a NetApp-Filer as NFS server (mostly from
SLES9 boxes). This does not seem to work any longer. So I digged a
little bit deeper:

The NetApp-Filer in question exports nearly 100 volumes:

sappscmn:/root>>> showmount --no-headers -e 10.172.230.134 | wc -l
96

All of them have access restrictions:

sappscmn:/root>>> showmount --no-headers -e 10.172.230.134 | awk '$2==""'
sappscmn:/root>>>
sappscmn:/root>>> showmount --no-headers -e 10.172.230.134 | head -5
/vol/nb/sles8/shared_os/var_img/var-0aac118a        10.172.17.138
/vol/nb/sles9_ia32/shared_os/root_aclm              10.172.17.99
/vol/nb/sles9_ia32/shared_os/var_img/var-0aac1163   10.172.17.99
/vol/nb/sles9_ia32/shared_os/root_cmsa_p
10.172.17.122,10.172.17.123
/vol/nb/sles9_ia32/shared_os/var_img/var-0aac1164   10.172.17.100


My IP-address is

sappscmn:/root>>> ip route list dev eth1
10.172.230.0/24  proto kernel  scope link  src 10.172.230.142
169.254.0.0/16  scope link

There is one volume accessible from the current host:

sappscmn:/root>>> showmount --no-headers -e 10.172.230.134 | grep
10.172.230.0/24
/vol/pcc
172.18.144.122,172.18.11.179,172.18.214.253,172.18.144.64/26,172.18.139.0/26,10.172.139.0/26,172.18.230.0/24,10.172.230.0/24,10.172.17.0/24,10.172.144.128/26,172.24.207.0/24,172.18.139.10,172.18.30.224/27,172.18.102.0/24,172.18.107.0/24,172.18.95.0/24,172.18.228.0/24,10.172.144.192/26,10.172.144.64/26,172.18.131.0/24,10.125.1.35,172.18.28.0/24,10.172.143.0/27,172.18.170.0/24,172.18.117.133,172.18.95.180,172.18.229.0/24,172.18.30.192/27,172.18.158.0/24,172.18.96.128/25
sappscmn:/root>>>

No other volume may be mounted.

Nevertheless automount tries to mount all volumes.

Running /etc/auto.net gives me:

sappscmn:/root>>> /etc/auto.net 10.172.230.134
-fstype=nfs,hard,intr,nodev,nosuid \
         /vol/acid 10.172.230.134:/vol/acid \
         /vol/casm_log/casm_log 10.172.230.134:/vol/casm_log/casm_log \
         /vol/casm_log 10.172.230.134:/vol/casm_log \
         /vol/casm 10.172.230.134:/vol/casm \
...
         /vol/pcc 10.172.230.134:/vol/pcc \
...

sappscmn:/root>>> /etc/init.d/autofs start
Starting service automounter                                         done
sappscmn:/root>>> cd /net/10.172.230.134/vol/pcc
bash: cd: /net/10.172.230.134/vol/pcc: No such file or directory
sappscmn:/root>>>

/var/log/messages shows quite clearly:

Apr 27 11:25:05 sappscmn automount[7822]: >> mount: 
10.172.230.134:/vol/acid failed, reason given by server: Permission denied
Apr 27 11:25:05 sappscmn automount[7822]: mount(nfs): nfs: mount failure 
10.172.230.134:/vol/acid on /net/10.172.230.134/vol/acid
Apr 27 11:25:05 sappscmn automount[7822]: >> mount: 
10.172.230.134:/vol/casm_log/casm_log failed, reason given by server: 
Permission denied

Up to this point there are no news. This happened always.

Unfortunately the volume I want to access cannot be mounted any longer:

...
Apr 27 11:25:06 sappscmn automount[7822]: >> mount: 
10.172.230.134:/vol/nb/sles9_ia32/shared_os/root_cms_p failed, reason 
given by server: Permission denied
Apr 27 11:25:06 sappscmn automount[7822]: mount(nfs): nfs: mount failure 
10.172.230.134:/vol/nb/sles9_ia32/shared_os/root_cms_p on 
/net/10.172.230.134/vol/nb/sles9_ia32/shared_os/root_cms_p
Apr 27 11:25:06 sappscmn automount[7822]: >> mount: fs type, bad option, 
bad superblock ... or too many mounted file systems
Apr 27 11:25:06 sappscmn automount[7876]: >> /usr/sbin/showmount: can't 
get address for 10.172.230.134/vol/pcc
Apr 27 11:25:06 sappscmn automount[7876]: lookup(program): lookup for 
10.172.230.134/vol/pcc failed
Apr 27 11:25:06 sappscmn automount[7876]: failed to mount 
/net/10.172.230.134/vol/pcc

If I change /etc/auto.net from

$SHOWMOUNT | LC_ALL=C sort -k 1 | \

to

$SHOWMOUNT | LC_ALL=C sort -k 1 | grep 10.172.230.0/24 | \

everything works well.

But this is a hack.

So my questions:

Is it possible make showmount show only volumes, I could mount
succesful and to suppress those, that will fail ?

Are there know problems with large export list (It used to work
before, but the NetApp-Filer became bigger and bigger ...)

Any other hints ?

Thanks for your time !

Kind regards

Gerd
