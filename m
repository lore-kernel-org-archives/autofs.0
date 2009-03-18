From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: autofs5 early daemonization side effects
Date: Wed, 18 Mar 2009 11:10:21 -0300
Message-ID: <c2d0b6ec0903180710s63e5aaa7r567c66d1139dd718@mail.gmail.com>
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

Hello,

I've been doing some tests with AutoFS5 and I'd like to confirm that
the behavior I'm seeing during the daemon initialization is expected
or not.

The problem: when the autofs initscript returns, autofs is not really
ready.

Reading the code, I see that the automount daemon detaches itself from
the controlling terminal (becoming a daemon) early in its initialization.
After that, it starts other threads to handle different tasks and just then
reads the available maps. Normally, reading the maps is quick, but it
could take a bit more if using NIS or LDAP, what explains the delay
between the initscript returning (immediately after daemonization) and
autofs being really ready to proceed.

I was thinking about some options to work around this problem (like deferring
daemonization), but after a while, I couldn't find a clean and non-intrusive
solution. Can you help me here?

Thanks,
Leonardo
