From: "Andreas Neuper" <ANeuper@web.de>
Subject: Re: Is the "program" format correct ?
Date: Sat, 14 Aug 2004 18:21:21 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1411896967@web.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Thank you Takashi,

this confirms my oppinion:  The format for program maps differs!
Usual and documented format is:
        key [-options] location

These maps swallow the key and accept only nfs location codes
where the hostname seems to be overwritten with the key. !?!

It seems strange to me. just try to use it for the floppy. I get 
errors on hostname resolution! (even when omitting the key) 

Is there a working release?
Andreas
____________________________________________________
Aufnehmen, abschicken, nah sein - So einfach ist 
WEB.DE Video-Mail: http://freemail.web.de/?mc=021200
