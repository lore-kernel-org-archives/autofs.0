From: Tom Georgoulias <tom.georgoulias@freescale.com>
Subject: Re: Severe problem with 4.1.2: automount caches NIS maps
 forever
Date: Thu, 06 May 2004 16:07:55 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <409AA92B.8050104@freescale.com>
References: <200405061811.i46IBbbv019272@miguelito.qualcomm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200405061811.i46IBbbv019272@miguelito.qualcomm.com>
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
Cc: autofs@linux.kernel.org

mmarion@qualcomm.com wrote:
> On  6 May, Bryan O'Sullivan wrote:
>>The autofs 4.1.2 release has a change in behaviour from earlier releases
>>(4.1.0, I think, and 4.0.0 for sure) in that it never checks to see if a
>>NIS-based automount map has changed.

> I noticed this too and did a workaround...

Why was the behavor changed between releases?  I was asking about this 
in my other message and now I see that two other people can confirm the 
need to HUP for daemons to use new map changes.

Tom
-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Freescale Semiconductor Internal Use
[] Freescale Semiconductor Confidential Proprietary
