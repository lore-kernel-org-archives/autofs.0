From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: 	Severe problem with 4.1.2: automount caches NIS maps
	forever
Date: Thu, 06 May 2004 14:22:38 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <409AAC9E.9000505@sedona.intel.com>
References: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
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
To: Bryan O'Sullivan <bos@serpentine.com>
Cc: autofs@linux.kernel.org

Bryan O'Sullivan wrote:

>Hi -
>
>The autofs 4.1.2 release has a change in behaviour from earlier releases
>(4.1.0, I think, and 4.0.0 for sure) in that it never checks to see if a
>NIS-based automount map has changed.  This means that if I change the
>location of an autofs-mounted filesystem, I have to SIGHUP the automount
>daemons on every machine that care about that filesystem so that they'll
>forget the contents of the map and reload it.
>
>Needless to say, this doesn't scale in even a tiny way :-(
>  
>
Agreed.  You would think with all the testing I have done, I would have 
seen this one.

I can easily replicate it and fix it with a SIGHUP.

Ian, do you have any thoughts on this one?

Michael



Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.
