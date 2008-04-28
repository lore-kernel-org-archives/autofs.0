From: Stef Bon <stef@bononline.nl>
Subject: include a master file: where does the automounter look
Date: Mon, 28 Apr 2008 10:32:52 +0200
Message-ID: <48158BB4.3050008@bononline.nl>
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

when I read the manpage for auto.master (and other docs) I see that I 
can include another master file by doing:

+auto.master

The comment says that by doing so, the you can specify a master map 
which is found using
nsswitch sources.
What happens then? Where does it look then?

When I add a line with an auto.master file with full path:

+/var/run/autofs/auto.master

it works also.

Stef
