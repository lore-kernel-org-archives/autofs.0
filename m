From: Greg Bradner <gregb@rhythm.com>
Subject: shut down path
Date: Fri, 26 Mar 2004 05:53:03 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <406435BF.4090801@rhythm.com>
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

Why or what would cause autofs to 'shut down' a path?
from /var/log/messages:
Mar 24 16:41:16 lid2 automount[992]: shut down, path = /ntap12

I am running autofs-4.1.0.
redhat 7.3
kernel 2.4.25

I am using the autofs4 module that ships which 7.3
# modinfo autofs4
filename:    /lib/modules/2.4.25/kernel/fs/autofs4/autofs4.o
description: <none>
author:      <none>
license:     "GPL"

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com
