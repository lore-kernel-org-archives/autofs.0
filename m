From: Ian Kent <raven@themaw.net>
Subject: Re: autofs not mounting directories
Date: Wed, 17 Mar 2004 11:24:36 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
References: <200403160358.MAA25667@tk3p108pos.tky.swissbank.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403160358.MAA25667@tk3p108pos.tky.swissbank.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Noel Hunt <huntno@ubs.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 16 Mar 2004, Noel Hunt wrote:

> 
> If `directory' is an automount mountpoint, is there some
> difference between `cd directory', and say cron running
> `/directory/bin/cmd', in the way that `directory' is
> accessed? I understand the former will cause a chdir()
> which will invoke autofs_root_lookup(); in the latter case,
> I don't know what goes on.

Yes.

Sounds like you may be suffering from the same problem that was reported 
by Michael Blandford. I'm mystified I haven't seen the problem before as 
it is so fundamental to proper operation.

I'll be looking to get a test group together from the list in a couple of 
days.

Ian
