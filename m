From: Richard Gillman <R.Gillman@nerc.ac.uk>
Subject: -Dvariable=value not working?
Date: Wed, 28 Jul 2010 13:19:52 +0100
Message-ID: <4C502068.1070104@nerc.ac.uk>
Reply-To: R.Gillman@nerc.ac.uk
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

I've got a Suse SLES 11 system running automount 5.0.3 which stubbornly 
refuses to variable substitution.

friesian:/etc/sysconfig # automount -V

Linux automount version 5.0.3

Directories:

config dir: /etc/sysconfig

maps dir: /etc

modules dir: /usr/lib64/autofs

Compile options:

DISABLE_MOUNT_LOCKING ENABLE_FORCED_SHUTDOWN ENABLE_IGNORE_BUSY_MOUNTS

WITH_LDAP WITH_SASL LIBXML2_WORKAROUND


I've got LOCAL_OPTIONS="-DNERCARCH=linux" in /etc/sysconfig/autofs (I've 
also tried "-D  NERCARCH=linux", "-D NERCARCH='linux'").

I've stopped nscd.

I've restarted automount /etc/init.d/autofs restart

friesian:/etc/sysconfig # ps -ef|grep automount

root 14378 1 0 11:12 ? 00:00:00 /usr/sbin/automount -p 
/var/run/automount.pid -O -DNERCARCH=linux

If I now do a ls /nerc/bin (one of my automounted directories),
friesian:/etc/sysconfig # ls /nerc/bin
ls: cannot open directory /nerc/bin: No such file or directory
friesian:/etc/sysconfig #

and I get the following in syslog.

Jul 28 10:30:03 friesian automount[13976]: lookup_mount: lookup(ldap): 
bin -> -ro mercury:/local/master/$NERCARCH/bin
Jul 28 10:30:03 friesian automount[13976]: parse_mount: parse(sun): 
expanded entry: -ro mercury:/local/master//bin

No substitution of the NERCARCH variable.

On another system, this time CentOS 5.5

Linux automount version 5.0.1-0.rc2.143.el5


Directories:

config dir: /etc/sysconfig

maps dir: /etc

modules dir: /usr/lib64/autofs


Compile options:

DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD WITH_LDAP

WITH_SASL

[root@who1 sysconfig]# ps -ef|grep auto

root 10263 1 0 10:59 ? 00:00:00 automount -DNERCARCH=linux

root 10320 10162 0 10:59 pts/4 00:00:00 grep auto


[root@who1 sysconfig]# ls /nerc/bin
env_clean  lookup  rc.d  setup_type
[root@who1 sysconfig]#

I get in syslog,

Jul 28 10:52:26 who1 automount[10210]: lookup_mount: lookup(ldap): bin 
-> orwell:/itsspool/master.itss/$NERCARCH/bin

Jul 28 10:52:26 who1 automount[10210]: parse_mount: parse(sun): expanded 
entry: orwell:/itsspool/master.itss/linux/bin

Which is what I would expect to see.

Any suggestions as to what I might be doing wrong on the Suse box?

tia, Dick


-- 
Richard Gillman
IST UNIX Systems Group, Maclean Building, Wallingford OX10 8BB
Tel: 01491 - 692 339
Fax: 01491 - 692 424
