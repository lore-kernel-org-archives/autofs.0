From: Michael Blandford <michael@kmaclub.com>
Subject: Problem with autofs 3.1.7 -> 4.1.0-beta2
Date: Sat, 06 Dec 2003 21:34:45 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FD2ADE5.6050403@kmaclub.com>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hello,

I am currently running autofs 3.1.7 from Fedora Core 1.  I am trying to 
upgrade to 4.1.0-beta2 from atrpms.

I recently switched to using ldap.  I admit I dont understand it the way 
I do NIS..but anyway.  Here is what my "map" looks like:

auto.services:
/       fileserver:/export/services/&
a       fileserver:/export2/a
b       fileserver:/export2/b
c       fileserver:/export2/c
d       fileserver:/export2/d

This works fine under 3.1.7.  With 4.1.0, cd'ing into 
/services/<anything> results in /export2/b getting mounted.  I can't 
understand this at all.

Any thoughts on how to fix this or debug the problem?

Michael
