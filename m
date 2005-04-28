From: "Brian Stevens" <brian@stevens.com>
Subject: Q: Does nsswitch and/or +ypmapname work for indirect maps?
Date: Thu, 28 Apr 2005 10:19:16 -0500 (CDT)
Message-ID: <37886.67.79.20.83.1114701556.squirrel@www.prettygood.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Should the "+ypmapname" and/or nsswitch.conf allow an indirect map to pick
up entries from both a local file AND a NIS map?  I have tried many
revisions of autofs 4.1.3 with kernels 2.4.21 and 2.6.x, and what I am
experiencing does not seem to correlate with the ChangeLogs I've read.

I have an auto.master map which includes "/apps auto.apps".  auto.apps is
distributed via NIS.  I would like, on one host, to override one of the
NIS entries with a local one.  I created a local /etc/auto.apps with
"oracle hous0117:/vol/vol013/oracle-hous0138".  I would like the /apps
automount to use that local entry from oracle, but also grab any other
entries from the NIS map.  I have found that I can get the indirect map to
use the local file OR the NIS map, but not both.

Is that possible?  Should it work?

Many thanks for any input!

Brian
