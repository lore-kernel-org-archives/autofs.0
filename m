From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Re: autofs not unmounting mount points?
Date: Wed, 17 Mar 2004 09:50:20 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40588FDC.5020909@intel.com>
References: <4051DB39.4060905@astro.wisc.edu>
	<Pine.LNX.4.58.0403141018340.4585@raven.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> On Fri, 12 Mar 2004, jansen wrote:
> 
> 
>>Hi,
>>
>>I've been struggling to figure out why autofs does not appear
>>to unmount many mount points.  I have more than 150 entries in
>>a map file and most of these entries get mounted when I log into
>>a Gnome session and never seem to ever get unmounted.  This
>>happened under RedHat 8.0 (autofs-3.1.7-33) and still happens on
>>SuSE 9.0 (autofs-3.1.7-717).  I'm guessing that Nautilus is doing
>>this.  Is anyone else seeing this?  Any suggestions on how to prevent
>>or debug this?  I can provide more details if anyone is interested.
> 
> 
> Bit unfortunate they never umount.
> 
> The problem is that Nautilus scans the directory if/when it notices umount 
> activity. This causes a remount. I couldn't find a way to trun it off. The 
> list of directories to scan is help in a file (I can't remember where now) 
> and I was able to stop it, to some extent, by cleaning it out and changing 
> the modes on the file (for non-root login anyway).
> 
> I started working on this some time ago but did not get anywhere before 
> other things took priority. To fix this means digging into Nautilius. A 
> significant task in itself. The people on the Nautilus list would probably 
> help but they would need a significant time investment from an autofs 
> development person. Any volunteers?

Although I am not really an autofs development person, I would really 
like this remedied, so I will volunteer.  Where can I get started?

Forrest
