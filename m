From: weiler@soe.ucsc.edu
Subject: Autofs weirdness in nsswitch.conf and other stuff...
Date: Thu, 15 Mar 2007 15:05:00 -0700 (PDT)
Message-ID: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu>
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

Hey all-

I'm testing out CentOS 5 (i.e. RedHat 5) and and playing around with
autofs 5.0.1 which is the version that ships with it.  I'm noticing three
odd things based on what I was seeing in RedHat 4.4 (which has autofs
4.1.3):

1: Before, with autofs 4.1.3, I had in /etc/nsswitch.conf:

automount: files ldap

And I had some maps in /etc/auto.master that mounted AND I had some maps
in LDAP that mounted, both worked OK together.  But in Autofs 5.0.1, the
same line in nsswitch.conf only lets me use whatever is first, i.e. if
files is listed first it automounts with flat files but not LDAP, or vice
versa.  Is there any way to get them BOTH working again, or is this a
nifty feature that has been removed?

2: When it loads flat files from auto.master locally, I see all the maps
mount at once randomly, i.e. if I have 1 map with 10 mounts listed in it,
I see them ALL mount at once!  Even though I didn't access them.  They
seem to come and go randomly...  Is this normal with autofs 5?

3: I used to see this when I did a "ps -ef | grep automount" in autofs 4.1.3:

% ps -ef | grep automount
[root@lutra ~]# ps -ef | grep automount
root      3373     1  0 Mar14 ?        00:00:00 /usr/sbin/automount
--timeout=6000 /cluster file /etc/auto.cluster intr
root      3442     1  0 Mar14 ?        00:00:00 /usr/sbin/automount
--timeout=6000 /share file /etc/auto.share
root      3489     1  0 Mar14 ?        00:00:00 /usr/sbin/automount
--timeout=60 --ghost /home ldap nisMapName=auto.home,dc=someuniv,dc=edu
-hard,intr,rw
root      3565     1  0 Mar14 ?        00:00:00 /usr/sbin/automount
--timeout=60 --ghost /projects ldap
nisMapName=auto.projects,dc=someuniv,dc=edu -hard,intr,rw

But now all I see on 5.0.1 is:

% ps -ef | grep automount:
root     25274     1  0 14:43 ?        00:00:00 automount
root     25451 18488  0 15:02 pts/1    00:00:00 grep automount

Not nearly as descriptive as to *what* is actually live or not...

Thanks for any hints!!

-erich
