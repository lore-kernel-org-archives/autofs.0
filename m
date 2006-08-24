From: Piete Brooks <Piete.Brooks--autofs@cl.cam.ac.uk>
Subject: What is the syntax for bind mounts under autofs 5 ?
Date: Thu, 24 Aug 2006 13:39:16 +0100
Message-ID: <E1GGEUO-0004FJ-00@mta2.cl.cam.ac.uk>
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

I used to be able to use:

	foo	:/usr/local/foo

to cause autofs to do a bind mount of "foo" to the local directory 
/usr/local/foo but under autofs 5 it fails. With "automount -d -v" I get:

Aug 24 13:36:21 pbtest8 automount[3657]: attempting to mount entry /mount/foo
Aug 24 13:36:21 pbtest8 automount[3657]: failed to mount /mount/foo

I also tried:

	foo -fstype=bind :/usr/local/foo

but that didn't work either. Any suggestions?
