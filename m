From: CHakri Deverapalli <cdeverapalli@yahoo.com>
Subject: NFS Help
Date: Fri, 1 Oct 2004 13:27:20 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20041001202720.49624.qmail@web51107.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="windows-1252"
To: autofs@linux.kernel.org

Hi,=20
   I am linux newbie and am having some problems with
NFS hope someone could help. Here is what my problem
is.
1.My previous Administrator has set up a list of
directories that are shared from a NFS server onto a
VMS client, now I want to add another client (linux)
onto this list. So I have changed my /etc/exports file
to include the client2 and it looks like this.
/home/data/nfs
my.client1-VMS.ip.add(ro)my.client2.ip.add(ro)
/home/data/disk1/1999 my.client1-VMS.ip.add(ro)
my.client2.ip.add(ro)
/home/data/disk2/1996 my.client1-VMS.ip.add(ro)
my.client2.ip.add(ro)
/home/data/disk2/1997 my.client1-VMS.ip.add(ro)
my.client2.ip.add(ro)
/home/data/disk3/2000 my.client1-VMS.ip.add(ro)
my.client2.ip.add(ro)
/home/data/disk4/1998 my.client1-VMS.ip.add(ro)
my.client2.ip.add(ro)
=95All the directories belong to the user =93data=94 and the
group =93uvi=94 I have changed them to be owned by root
both the user and group belongs to root now.
2. You have tied down the /etc/sysconfig/ipchains and
/etc/hosts.allow , I have changed them to look like
this now.
=95:input ACCEPT
:forward ACCEPT
:output ACCEPT
-A input -s 0/0 -d 0/0 137 -p tcp -y -j ACCEPT
-A input -s 0/0 -d 0/0 137 -p udp  -j ACCEPT
-A input -s 0/0 -d 0/0 138 -p tcp -y -j ACCEPT
-A input -s 0/0 -d 0/0 138 -p udp  -j ACCEPT
-A input -s 0/0 -d 0/0 139 -p tcp -y -j ACCEPT
-A input -s 0/0 -d 0/0 139 -p udp  -j ACCEPT
-A input -s my.client1-VMS.ip.add -d 0/0 111 -p tcp -y
-j ACCEPT
-A input -s my.client1-VMS.ip.add -d 0/0 111 -p udp =20
-j ACCEPT
-A input -s my.client1-VMS.ip.add -d 0/0 2049 -p tcp
-y -j ACCEPT
-A input -s my.client1-VMS.ip.add -d 0/0 2049 -p udp =20
-j ACCEPT
-A input -s my.client2.ip.add -d 0/0 111 -p tcp -y -j
ACCEPT
-A input -s my.client2.ip.add -d 0/0 111 -p udp   -j
ACCEPT
-A input -s my.client2.ip.add -d 0/0 2049 -p tcp -y -j
ACCEPT
-A input -s my.client2.ip.add -d 0/0 2049 -p udp   -j
ACCEPT
-A input -s 0/0 -d 0/0 22 -p tcp -y -j ACCEPT
-A input -s 0/0 -d 0/0 21 -p tcp -y -j ACCEPT
-A input -s 0/0 -d 0/0 21 -p udp -j ACCEPT
-A input -s 0/0 -d 0/0 -i lo -j ACCEPT
-A input -p tcp -s 0/0 -d 0/0 0:1023 -y -j REJECT
-A input -p tcp -s 0/0 -d 0/0 2049 -y -j REJECT
-A input -p udp -s 0/0 -d 0/0 0:1023 -j REJECT
-A input -p udp -s 0/0 -d 0/0 2049 -j REJECT
-A input -p tcp -s 0/0 -d 0/0 6000:6009 -y -j REJECT
-A input -p tcp -s 0/0 -d 0/0 7100 -y -j REJECT
=95sshd: my.sub.domain.
portmap: my.client1-VMS.ip.add my.client2.ip.add
nfsd: my.client1-VMS.ip.add my.client2.ip.add
rpc.mountd: my.client1-VMS.ip.add my.client2.ip.add
in.ftpd: my.client1-VMS.ip.add  my.client2.ip.add
3.Did an NFS restart on the NFS server machine.
4. On the client machine I use the following command.
Mount  =96tnfs  my.nfs-server.ip.add:/home/data/nfs
/home/data/nfs
=95I have created the same directory structure on the
client also.
5.I can mount it without problems but when I try a
simple command like =93ls=94 my        system hangs up.
6.I have created some new directories for test
purposes and I can mount them and view their contents
without any problems. But the old ones I am not able
to mount them.
Could you suggest what I am doing wrong or what I have
missed?

thanks,
Chakri.
=20



=3D=3D=3D=3D=3D
D.M.C.Chakravarthy
Research Associate
Center for Space Plasma and Aeronomy Research
University of Alabama in Huntsville
Ph:256-824-3485(O),256-824-6664(O)
    256-890-8800(H)
    256-479=3D9420(Cell)


	=09
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail=20
