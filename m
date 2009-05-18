From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: strange regression in ldap support between 5.3 and 5.4
Date: Mon, 18 May 2009 21:50:14 +0200
Message-ID: <4A11BBF6.5020906@inria.fr>
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

Hello list.

I have a user reporting a strange regression after updating from linux 
mandriva 2009.0 (shipping autofs 5.0.3 + all patches until 
fix-couple-of-memory-leaks.patch) to mandriva 2009.1 (shipping autofs 
5.4 + all patches until clear-rpc-client-on-lookup-fail.patch): 
apparently, keys defined in indirect maps are mounted directly on the 
mount point, instead of a subdir:

https://qa.mandriva.com/show_bug.cgi?id=50631

The debug output is apparently not consistent with mount output:
mounted /home/lsc/luizd
vs
sol.lsc.ufsc.br:/export/lsc/home/luizd on /home/lsc type nfs

Curiously, file based maps works OK. But, the only ldap-related changes 
I see in the applied patches set (5.0.3 with all patches is basically 
5.0.4) is a memory leak fix, and a build-time detection fix.

Does someones see something else ?

-- 
BOFH excuse #323:

Your processor has processed too many instructions.  Turn it off 
immediately, do not type any commands!!
