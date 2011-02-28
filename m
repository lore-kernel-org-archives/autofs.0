From: Greg Wooledge <wooledg@eeg.ccf.org>
Subject: Re: adding new file systems to host map
Date: Mon, 28 Feb 2011 08:21:23 -0500
Message-ID: <20110228132123.GY16849@eeg.ccf.org>
References: <AANLkTikM2UyUa7xANa5LKnWe3S7LGCb+CU_nbNs5R-E1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikM2UyUa7xANa5LKnWe3S7LGCb+CU_nbNs5R-E1@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Michael Coffman <michael.coffman@avagotech.com>
Cc: autofs@linux.kernel.org

On Thu, Feb 24, 2011 at 07:27:07AM -0700, Michael Coffman wrote:
> If I am using host mapping on an autofs client and have a file system from a
> server mounted, how do I get new file systems that are added to the file
> server to be seen by the client?

When I asked a similar question a few months ago, the answer was
essentially "you can't".  The only foolproof solution as far as I know
is to reboot the client machines.
