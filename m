From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Fri, 09 Jan 2004 12:17:12 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFF0C48.6020908@zytor.com>
References: <Pine.LNX.4.44.0401031051350.4413-100000@raven.themaw.net>
	<Pine.LNX.4.53.0401091118050.9335@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0401091118050.9335@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

Jim Carter wrote:
> 
>>A kill -9 on the blocked process needs further investigation. I'm not sure
>>what the situation is there (probably not good).
> 
> I would really like it if, when autofs decided to forcibly unmount, it
> could kill the using processes, as in "fuser -k -m /net/host/mountpoint".
> Actually this is a general issue for unmount(8), not specific to autofs.
> But one wonders whether fuser is going to run wild...
> 

How on the face of planet Earth do you expect autofs should ever take
such a drastic action?  This could only by a human deciding to do so,
and if so, it's not an issue for autofs, as long as human umounts are
properly handled (they should be.)

	-hpa
