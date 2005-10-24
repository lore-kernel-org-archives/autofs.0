From: devnull@adc.idt.com
Subject: autofs looks up wrong path element metoo and /net question
Date: Mon, 24 Oct 2005 17:16:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0509271133270.9747@pod.adc.idt.com>
References: <200509251900.j8PJ0HIm008775@hera.kernel.org>
Reply-To: devnull@adc.idt.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200509251900.j8PJ0HIm008775@hera.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: AutoFS on Linux Kernel <autofs@linux.kernel.org>

Ian, list.

Fedora Core 2

/usr/sbin/automount -V
Linux automount version 4.1.4

I am running automount with /usr/sbin/automount --ghost -v --debug

uname -r
2.6.7 / 2.4.31

I have "yp" autofs maps that are 2 directories deep. For eg. 
/projects/map1 /projects/map2 etc and then I mount 
different projects under them, project1 project2 etc

/projects/map1/projectA
/projects/map1/projectB

/projects/map2/projectC
/projects/map2/projectD

/projects/map3/projectE
/projects/map3/projectF

/projects/map4/projectG
/projects/map4/projectH

Sometimes on these machines, users find that their jobs are killed because 
they were unable to "cd" into /projects/map1/projectA for eg.

They see something similar to

irn:/projects/map1/projectA > ll
total 0
?---------  ? ? ? ?           ? dir1
?---------  ? ? ? ?           ? dir2
irn:/projects/map1/projectsA > cd dir1
dir1: No such file or directory.


If I look at the messages file at the same time, I see entries like

Oct 24 16:44:36 irn automount[2202]: attempting to mount entry 
/projects/map1/map2
Oct 24 16:44:36 irn automount[19851]: lookup(yp): lookup for map2 failed: 
No such key in map
Oct 24 16:44:36 irn automount[19851]: failed to mount /projects/map1/map2
Oct 24 16:44:36 irn automount[2189]: attempting to mount entry 
/projects/map2/map2
Oct 24 16:44:36 irn automount[19852]: lookup(yp): lookup for map2 failed: 
No such key in map
Oct 24 16:44:36 irn automount[19852]: failed to mount /projects/map2/map2
Oct 24 16:44:36 irn automount[2098]: attempting to mount entry 
/projects/map3/map2
Oct 24 16:44:36 irn automount[19853]: lookup(yp): lookup for map2 failed: 
No such key in map
Oct 24 16:44:36 irn automount[19853]: failed to mount /projects/map3/map2
Oct 24 16:44:36 irn automount[2118]: attempting to mount entry 
/projects/map4/map2
Oct 24 16:44:36 irn automount[19854]: lookup(yp): lookup for map2 failed: 
No such key in map
Oct 24 16:44:36 irn automount[19854]: failed to mount /projects/map4/map2



Right after these messages I also see

Oct 24 16:31:55 irn automount[2145]: attempting to mount entry 
/projects/map2/projectA
Oct 24 16:31:55 irn automount[19134]: lookup(yp): lookup for projectA
failed: No such key in map
Oct 24 16:31:56 irn automount[19134]: failed to mount 
/projects/map2/projectA

Oct 24 16:31:55 irn automount[2145]: attempting to mount entry 
/projects/map3/projectA
Oct 24 16:31:55 irn automount[19134]: lookup(yp): lookup for projectA
failed: No such key in map
Oct 24 16:31:56 irn automount[19134]: failed to mount 
/projects/map3/projectA

Oct 24 16:31:55 irn automount[2145]: attempting to mount entry 
/projects/map3/projectA
Oct 24 16:31:55 irn automount[19134]: lookup(yp): lookup for projectA
failed: No such key in map
Oct 24 16:31:56 irn automount[19134]: failed to mount 
/projects/map3/projectA


It will do this for all maps, but the correct map which is "map1"

The actual automount process for "map1" is running and after a few 
minutes/retries things come back to normal. Sometimes they dont and I need 
to reboot this machine/restart automount for that map.


Is something getting incorrectly parsed and being sent to automount ?


Thanks
