From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS problem
Date: Fri, 28 May 2004 10:14:57 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405281014240.6708@wombat.indigo.net.au>
References: <5a3315fad7.5fad75a331@sorint.it>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <5a3315fad7.5fad75a331@sorint.it>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giovanni Romanenghi <giovanni.romanenghi@sorint.it>
Cc: autofs@linux.kernel.org

On Wed, 26 May 2004, Giovanni Romanenghi wrote:

> I configure my sun java desktop to authenticate with ldap server ( Sun Java System Directory server 5.1 Sp3) and I configure autofs to mount user home directory at logon and it works .
> 
> My problem is that the clients don't mount other file systems that aren't home directory.
> 
> All file systems that the workstation must mount are configured on ldap server.
> 
> When I connect from my workstation with my user giovanni , I view my home directory but the autofs doesn't mount the disk /u and /prova.
> 
> The nfs server is ok because i can mount all share from my workstation manually.
> My /etc/exports:
> /tmp/tmp (rw,sync,no_root_squash)
> /tmp/u (rw,sync,no_root_squash)
> /var/prova (rw,sync,no_root_squash)
> 
> /etc/init.d/autofs status:
> Configured Mount Points:
> ------------------------
> /usr/sbin/automount /u ldap ldap.:.it:ou=auto.u,o=test.it,dc=test,dc=it
> /usr/sbin/automount /home ldap ldap.test.it:ou=auto.home,o=test.it,dc=test,dc=it
> /usr/sbin/automount /prova ldap ldap.test.it:ou=auto.prova,o=test.it,dc=test,dc=it
> 
> Active Mount Points:
> --------------------
> /usr/sbin/automount /u ldap ldap.test.it:ou=auto.u,o=test.it,dc=test,dc=it
> /usr/sbin/automount /home ldap ldap.test.it:ou=auto.home,o=test.it,dc=test,dc=it
> /usr/sbin/automount /prova ldap ldap.test.it:ou=auto.prova,o=test.it,dc=test,dc=it
> 
> 
> This is my df -k:
> /dev/hda1 10490084 5951992 4538092 57% /
> /dev/hda4 5694860 4495668 1199192 79% /backup
> shmfs 127868 0 127868 0% /dev/shm
> /tmp/tmp/giovanni 10490084 5951992 4538092 57% /home/giovanni
> 
> 
> I install this version of autofs:
> autofs-3.1.7-731
> 
> Any Ideas?

What does one of your LDAP entries look like please.

Ian
