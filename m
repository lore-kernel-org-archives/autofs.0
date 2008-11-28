From: Ian Kent <raven@themaw.net>
Subject: Re: mailing list broken? cdfs automounting
Date: Fri, 28 Nov 2008 23:29:44 +0900
Message-ID: <1227882584.3007.1.camel@zeus.themaw.net>
References: <200811281251.37802.andreas.frisch@multimedia-labs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200811281251.37802.andreas.frisch@multimedia-labs.de>
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
To: Andreas Frisch <andreas.frisch@multimedia-labs.de>
Cc: autofs@linux.kernel.org

On Fri, 2008-11-28 at 12:51 +0100, Andreas Frisch wrote:
> dear list users,
> 
> i've tried to look at the mailing list archives on 
> http://linux.kernel.org/pipermail/autofs/
> but it gives me a 403 forbidden on that.

I've email the admin on kernel.org a couple of times about this but
nothing so far. I'll try again.

> 
> secondly, i have an issue about combing autofs and cdfs.
> when inserting a video-cd (vcd) in the cd-drive without cdfs loaded, i get an 
> autofs mountpoint where i can browse through the directories, no matter if the 
> medium is an originally pressed "compact disc digital video" medium or a self-
> burned vcd which just has the same file structure but differs physically.
> with cdfs kernel module loaded, i see 
> /autofs/sr0/sessions_1-1.iso                                          
> /autofs/sr0/videocd-1.mpeg  
> on an original vcd medium. the mpeg file can be accessed like a regular file 
> on a data cd (while the file /autofs/sr0/mpegav/avseq01.dat on a "real" vcd 
> without cdfs loaded, is inaccessible)
> when i insert a "fake" vcd (self-burned), then the autofs mount ONLY shows the 
> sessions_1-1.iso.
> the same thing occurs on "mixed mode" audio-cds. the "data track" is shown as 
> sessions_1-??.iso, while the raw audio tracks are being prefixed by a wav 
> header and resembled with the names track-??.wav by cdfs.
> my question now is: can autofs automatically loop-mount those "fake" iso 
> tracks simulated by cdfs on "special" cd media into a new autofs directory and 
> how do i have to proceed to do that?

Are you sure this is the right place for this question?
What is your current autofs configuration?

Ian
