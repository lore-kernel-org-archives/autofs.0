From: "Bruce W. Martin" <redhat@vuiis.vanderbilt.edu>
Subject: autofs and cifs syntax
Date: Tue, 9 May 2006 12:30:14 -0500
Message-ID: <C583AC26-AA06-4978-8483-9AB2CE102142@vuiis.vanderbilt.edu>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: autofs@linux.kernel.org

I have been looking at howtos and googling for a couple of weeks and  
can't seem to find the answer to fix an autofs problem.

I am using RHEL4 with a 2.6.9 kernel.


under RH7.3 and a 2.4.x kernel I had a /etc/auto.net file with the  
following entries:


dragon        -fstype=smbfs,rw,credentials=/opt/ 
dragonlo,gid=10009,fmask=660,dmask=770   ://10.1.1.223/anyuser
sting        -fstype=smbfs,rw,credentials=/opt/ 
stinglo,gid=10009,fmask=660,dmask=770   ://10.1.1.35/Export


This worked fine to mount /net/dragon and /net/sting.


Upgrading the machine to RHEL4 with a 2.6.9 kernel

I can still mount /net/dragon but not /net/sting. The difference  
between the two machine is that dragon/10.1.1.223is a Mac running  
MacOS 10.4.x and sting/10.1.1.35 is a WinXP machine.

A little more googling yielded that I should replace smbfs to cifs   
and as a result some of the other option names changed.

so now the entry for sting looks like this:

sting        -fstype=cifs,rw,credentials=/opt/ 
stinglo,uid=500,gid=10009,file_mode=0660,dir_mode=0770  ://10.1.1.35/ 
Export

but it still is not working.

Can someone tell me what is wrong and/or point me to documentation to  
get this to work.

Bruce


-- 
Bruce W. Martin, KQ4TV
Mt. Juliet, TN
EM66sf
