From: Chris Walker <cwalker@pixar.com>
Subject: statfs() and autofs
Date: Tue, 15 Jul 2008 13:48:39 -0700
Message-ID: <20080715204839.GU5858@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

autofs 5.0.3
linux 2.6.18

When statfs() is called on an automounted directory, it returns before
the automount occurs. This results in output like this initially:

% df /home/XXX
Filesystem           1K-blocks      Used Available Use% Mounted on
-                            0         0         0   -  /home

If df is run a second later,

% df /home/XXX
Filesystem           1K-blocks      Used Available Use% Mounted on
XXX:/home/XXX
                      80634688  77952736   2681952  97% /home/XXX

Perhaps there are options of which I'm not aware to mitigate this
behavior.

Apologies if the answer to my query lies elsewhere in the kernel.

-- 
Chris Walker -- cwalker@pixar.com
