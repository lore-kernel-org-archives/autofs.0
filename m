From: Ian Kent <raven@themaw.net>
Subject: Re: handle_packet_missing called with wrong path
Date: Tue, 24 May 2005 09:16:58 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0505240907230.26293@wombat.indigo.net.au>
References: <17041.64254.30905.109713@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0505240005230.3469@donald.themaw.net>
	<17042.4853.680049.888755@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17042.4853.680049.888755@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 23 May 2005, Jeff Moyer wrote:

> >> 
> >> Ian, any ideas on this?  The user was even kind enough to attach a
> >> reproducer (though I believe it takes a good deal of run-time to trigger
> >> the problem):

I'll try and duplicate this at home.
I probably won't get to it for a a few days though.

I've setup an old bucket of bolts as an FC3 test machine now.

> >> 
> >> #!/usr/bin/perl while (1) { open(IN,"<
> >> /data/radar3/saber/SABER_SPECTRA_2002_090_130M.DAT") or print `date`
> >> . ": Failed to open\n"; close(IN); sleep(70); }
> >> 
> >> The version of the automounter is autofs-4.1.4-8, and the kernel is
> >> FC3's latest, which is based off of 2.6.11.10, with the addition of the
> >> expiry race patch.
> 
> raven> I can't see how the expiry race patch could cause this but I'll keep
> raven> it in mind when I'm looking.
> 
> The problem has been reproduced with and without that patch applied.  I
> should have mentioned that, sorry.
> 

Understood.

Ian
