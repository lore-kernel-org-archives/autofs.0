From: Piete Brooks <Piete.Brooks@cl.cam.ac.uk>
Subject: Is there a known problem with recent Fedora systems core
	dumping?
Date: Thu, 05 Jun 2008 09:58:08 +0100
Message-ID: <E1K4BIO-0007Ps-00@mta2.cl.cam.ac.uk>
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

I've not managed to get a useful backtrace from the core dumps I get, but is 
there a known problem with the recent (6 .. 9) Fedora RPMs?
We use recursive mounts, but I think I've seen it when they aren't being used.
Basically a core dump appears in / and some part of the automount space stops 
working (but other bits still work).

Under Fedora Core 6 (autofs-5.0.1-0.rc3.33) it happened to just one research 
group (who do things differently from everyone else), but as of Fedora 9 
(autofs-5.0.3-15) it appears to happen to others (e.g. me!).
It's intermittent (e.g. about once per day)

Has anyone come across such a problem?

Thanks.
