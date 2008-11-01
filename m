From: Ian Kent <raven@themaw.net>
Subject: Re: a couple of bugs in autofs
Date: Sat, 01 Nov 2008 14:08:15 +0900
Message-ID: <1225516095.3718.29.camel@zeus.themaw.net>
References: <510ca9b40810302235v6ab05c8bk117d4991bb70f198@mail.gmail.com>
	<1225436514.2946.74.camel@zeus.themaw.net>
	<510ca9b40810310011o458ff36ftbcce12c850ae172e@mail.gmail.com>
	<1225438359.2946.82.camel@zeus.themaw.net>
	<510ca9b40810310052o2c418ec5sd47c9d3b056a894d@mail.gmail.com>
	<1225440162.2946.93.camel@zeus.themaw.net>
	<510ca9b40810310110s34cfab9cie464a259d9dd92a0@mail.gmail.com>
	<1225442150.2946.105.camel@zeus.themaw.net>
	<510ca9b40810310415l667b803bya357f07f11312ff3@mail.gmail.com>
	<510ca9b40810312050m4b181de1p2de40e3f2389da7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40810312050m4b181de1p2de40e3f2389da7a@mail.gmail.com>
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
To: Paul Wankadia <junyer@gmail.com>
Cc: autofs@linux.kernel.org

On Sat, 2008-11-01 at 14:50 +1100, Paul Wankadia wrote:
> On Fri, Oct 31, 2008 at 10:15 PM, Paul Wankadia <junyer@gmail.com> wrote:
> 
> > Well, parentheses are used to override precedence, so the patterns are
> > effectively unchanged.
> 
> I sit corrected! Adding the parentheses fixes the problem. The
> expansions at line 246 cause the patterns to be concatenated, but not
> quite how we expected.
> 
> Starting automounter version 5.0.3, master map /home/junyer/autofs/auto.master
> using kernel protocol version 5.00
> lookup_nss_read_master: reading master file /home/junyer/autofs/auto.master
> parse_init: parse(sun): init gathered global options: (null)
> lookup_read_master: lookup(file): read entry /autohome
> master_do_mount: mounting /autohome
> automount_path_to_fifo: fifo name /var/run/autofs.fifo-autohome
> lookup_nss_read_map: reading map file /etc/auto.home
> parse_init: parse(sun): init gathered global options: (null)
> mounted indirect mount for /autohome with timeout 300, freq 75 seconds
> Segmentation fault (core dumped)

Oops!

Get gdb output with "thr a a bt"

> 
> I'll find out why it's crashing.
