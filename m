From: Greg Bradner <gregb@rhythm.com>
Subject: sgi IRIX-6.5 autofs
Date: Wed, 06 Apr 2005 12:57:45 -0700
Message-ID: <42543F39.3030105@rhythm.com>
References: <20050403000945.GB22336@uio.no>	<Pine.LNX.4.58.0504051957560.1851@donald.themaw.net>	<20050405123425.GA20348@uio.no>
	<Pine.LNX.4.58.0504060958150.24274@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504060958150.24274@wombat.indigo.net.au>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

I have a situation on IRIX where I am stat'ing a filesystem that is not 
exported to the IRIX system.  The syslog says 'permission denied'.  
That's expected.  Since the directory I'm in has 600 links to the file 
system that is not exported, autofs keeps trying to mount and keeps 
getting 'permission denied'.

On linux I get 'permission denied', but it doesn't try to mount again 
for 30 minutes.

Has anyone heard of such a problem with IRIX's autofs and is there a fix?
Why does linux only try every 30 minutes?
TIA.

IRIX system:
 > uname -aR
IRIX64 r8 6.5 6.5.14f 10100655 IP27
 > versions -b | grep -i nfs
I  nfs                  10/28/2002  Network File System, 6.5.14f

LINUX system:
 > uname -ar
Linux lis9.rhythm.com 2.4.26 #9 SMP Fri May 7 18:22:13 PDT 2004 i686 unknown
 > /usr/sbin/automount4 -v
Linux automount version 4.1.0

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com
