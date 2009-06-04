From: Jim Dennis <jdennis@cadence.com>
Subject: /tmp/autoXXXXXX artifacts in /etc/mtab
Date: Wed, 3 Jun 2009 18:18:21 -0700
Message-ID: <3BE3DD53E8C764428441BEFE7FE94F163DF67D2B@MAILSJ4.global.cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Language: en-US
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
To: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>



 All,

 Running autofs version 5 (versions from RHEL4u7, RHEL5 and the upstream 5.0.4 with almost
 all of the patches applied) we're seeing quite a few issues with stray /tmp/auto* entries being
 left in the /etc/mtab file.

 The symptom is lots of error messages from df commands.

 Looking through the sources I see that autofs version 5 seems to implement its own internal
 mount handling (it's not just spawning process to run the /sbin/mount external command
 for any of the types of mounts for which it has a .so module).  I noticed that there are  three
 different places in the code which use tempfile template strings matching /tmp/autoXXXXXX.

 I haven't get been able to track the issue down further ... but I suspect there's a bug in the
 code that's updating /etc/mtab and which is supposed to be cleaning out these entries.
 We have a horrendously busy and complex automount infrastucture and we've uncovered
 locking issues on /etc/mtab in the past (from the /sbin/mount code as well as during the
 period of time when autofs4 was trying to wrap its own locking around its calls to the external
 mount command.

 I'll try to get a more detailed formal bug report together in the next week or so.  However, I
 figured I should put out an early message in case others are seeing this or already working on it.


--
Jim Dennis,
Senior Staff Linux Engineer, IT
Cadence Design Systems, Inc.
