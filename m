From: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: RE: is there an autofs roadmap somewhere?
Date: Fri, 25 Jun 2004 20:50:14 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1088221814.20816.42.camel@camp4.serpentine.com>
References: <482A3FA0050D21419C269D13989C611302B07D00@lavender-fe.eng.netapp.com>
	 <Pine.LNX.4.58.0406252306330.1375@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406252306330.1375@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On Fri, 2004-06-25 at 23:18 +0800, raven@themaw.net wrote:

> I've given some thought to a change in internal design. Introducing a 
> threaded model in fact. But having lots of processes around and a 
> cluttered mount table need to be considered, even with the current design.

Tim Hockin and some other people at Sun are implementing an automounter
from scratch.  I don't recall much about the design, other than that it
seemed a bit inspired by hotplug (i.e. run a program to handle a mount/
unmount request).  The only reaction I've seen was from HPA, who wasn't
terribly impressed.

You can find the original thread here:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0401.0/index.html#1415

	<b

-- 
Bryan O'Sullivan <bos@serpentine.com>
