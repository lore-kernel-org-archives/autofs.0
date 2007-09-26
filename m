From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: ctrl-C doesn't work
Date: Wed, 26 Sep 2007 11:15:20 +0100
Message-ID: <200709261115.20136.vda.linux@googlemail.com>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian,

I run automounter in foreground mode, and when I start it from command line,
it does not die on SIGINT:

automount -f -s -v --timeout 15 $PWD/master.file
Starting automounter version 5.0.0_beta1, master map /.local/var/service/automount/master.file
using kernel protocol version 5.00
using timeout 15 seconds; freq 4 secs
 -- I press ctrl-C several times
statemachine: got unexpected signal 2!
statemachine: got unexpected signal 2!
statemachine: got unexpected signal 2!

What do you think about making SIGINT equivalent to SIGTERM?
This will be more convenient...
--
vda
