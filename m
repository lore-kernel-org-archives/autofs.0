From: Robert Au <rau@lsil.com>
Subject: Re: autofs not mounting directories
Date: Wed, 17 Mar 2004 12:48:29 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040317204829.GD12204@vprau.lsil.com>
References: <200403160358.MAA25667@tk3p108pos.tky.swissbank.com>
	<Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Wed, Mar 17, 2004 at 11:24:36AM +0800, Ian Kent wrote:
> On Tue, 16 Mar 2004, Noel Hunt wrote:
> > If `directory' is an automount mountpoint, is there some
> > difference between `cd directory', and say cron running
> > `/directory/bin/cmd', in the way that `directory' is
> > accessed? I understand the former will cause a chdir()
> > which will invoke autofs_root_lookup(); in the latter case,
> > I don't know what goes on.
> 
> Yes.
> 
> Sounds like you may be suffering from the same problem that was reported 
> by Michael Blandford. I'm mystified I haven't seen the problem before as 
> it is so fundamental to proper operation.

I don't see Michael's original report in the list archives. Did he send it
to the list?
 
> I'll be looking to get a test group together from the list in a couple of 
> days.

I think we are seeing something similar here; sporadically, listing a file
with ls will fail until a process changes working directory to that file's
directory. I'd like to help out in the testing. We are seeing this problem
with Red Hat 7.2 (kernel 2.4.7-10), autofs 4.1.0, and kernel module
autofs4-2.4-module-20031201.

-- 
Robert Au                     rau@lsil.com
                              LSI Logic
