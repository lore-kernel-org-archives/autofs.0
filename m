From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [patch rfc] don't exit from parent until autofs can
	service requests
Date: Wed, 1 Jun 2005 10:39:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0506011034220.21159@simba.math.ucla.edu>
References: <17053.50761.832966.775060@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17053.50761.832966.775060@segfault.boston.redhat.com>
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

On Wed, 1 Jun 2005, Jeff Moyer wrote:
> The following patch addresses this by keeping the parent around until
> either the daemon fails to start, or is about ready to service mount
> requests.  

Hear, hear!  It's very important that when the init script exits the 
service is ready to go (or has positively failed).  If script completion 
means only that the service has started to get ready to begin 
initialization, then dependent services need to poll, which is a kludge and 
is subject to mistakes.  (My nemesis in this regard is udev.)

The testing sounds thorough.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
