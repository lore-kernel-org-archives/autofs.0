From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: sshfs and autofs
Date: Mon, 21 Dec 2009 11:32:46 +0100
Message-ID: <1261391275-sup-7258@nixos>
References: <1261107485-sup-320@nixos> <1261173402-sup-9510@nixos>
	<4B2E48C7.8010509@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <4B2E48C7.8010509@bononline.nl>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Stef Bon <stef@bononline.nl>
Cc: autofs <autofs@linux.kernel.org>

> > #  ls -l /auto
> > ls: cannot access /auto/mlin: Permission denied
> > total 0
> > d????????? ? ? ? ?                ? mlin
> >   
> Well the question marks mean that glibc cannot figure out the 
> permissions. This means probably
> that the mount has not been succesfull.
It was. The user can access it. But root can't.

> Does this work. I do not know anything about ssh agents.
Than you should start to learn at least some basics.
An ssh-agent is a process which keeps your "passwords" in memory to
unlock the .ssh/id_* keys.
Of course it works. I'm using it.
 
> I n my construction I'm using the following command:
> PasswordAuthentication='no' -o IdentityFile="$homedir/.ssh/id_dsa" -o 
This id_dsa, is it protected by password?
If you use google to find out how to use automount and sshfs you'll find
many instructions about how to generate a key with empty password and
how to configure automount. However using an empty password is not an
option for me.

> the directory /mnt/mount.md5key/%USER%
> is owned by the user and has permissions 700, so no other user except 
How do you assign these permissions 700 ?
I didn't suceed

Marc Weber
