From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Debugging hung autofs /home?
Date: Wed, 11 Jan 2006 12:20:24 -0500
Message-ID: <17349.15960.3317.504485@segfault.boston.redhat.com>
References: <43C29C28.5090407@deragon.biz> <43C4405B.7050706@cs.arizona.edu>
	<17348.18543.789713.377209@segfault.boston.redhat.com>
	<43C4490B.2010301@cs.arizona.edu>
	<17348.19024.416286.278340@segfault.boston.redhat.com>
	<43C53D9B.4080903@cs.arizona.edu>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43C53D9B.4080903@cs.arizona.edu>
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
Content-Type: text/plain; charset="us-ascii"
To: Jim Davis <jdavis@cs.arizona.edu>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Debugging hung autofs /home?; Jim Davis <jdavis@CS.Arizona.EDU> adds:

jdavis> Jeff Moyer wrote:
>> 
>> ewer one.
>> 
>> Interesting.  Then I'd suggest you provide the information requested in the
>> "Filing bug reports" section of my people page:
>> 
>> http://people.redhat.com/jmoyer/
>> 
jdavis> The somewhat lengthy file from the latest hang is at 
jdavis> http://www.cs.arizona.edu/people/jdavis/autofsbug.  If there's anything 
jdavis> else I can provide, let me know.  I have installed the 4-1-4.8 rpms, and 
jdavis> have strace running on the automount process controlling /home.

Turns out Ian is right.  The syslog fixes didn't go in until 4.1.4-8 (and
those fixes were a different implementation that what was committed in
4.1.4-10).  So, 4.1.4-10 is your best bet.  I'll see about updating the
Fedora packages soonish.

-Jeff
