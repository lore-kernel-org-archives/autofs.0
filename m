From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: autofs not mounting directories
Date: Wed, 17 Mar 2004 15:04:39 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4058CB77.8040900@sedona.intel.com>
References: <200403160358.MAA25667@tk3p108pos.tky.swissbank.com>
	<Pine.LNX.4.58.0403171118120.6566@wombat.indigo.net.au>
	<20040317204829.GD12204@vprau.lsil.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040317204829.GD12204@vprau.lsil.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Robert Au <rau@lsil.com>
Cc: autofs@linux.kernel.org

Robert Au wrote:

>I think we are seeing something similar here; sporadically, listing a file
>with ls will fail until a process changes working directory to that file's
>directory. I'd like to help out in the testing. We are seeing this problem
>with Red Hat 7.2 (kernel 2.4.7-10), autofs 4.1.0, and kernel module
>autofs4-2.4-module-20031201.
>  
>
I could replicate the problem by cd'ing into a directory ( that caused 
it to get automounted ) and try to touch a file.  It would fail.  cd out 
of the directory and back in and it would now work.  I only see this 
problem on 4.1.x.

Michael
