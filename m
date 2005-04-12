From: Greg Bradner <gregb@rhythm.com>
Subject: Re: sgi IRIX-6.5 autofs
Date: Tue, 12 Apr 2005 09:50:13 -0700
Message-ID: <425BFC45.8000909@rhythm.com>
References: <20050403000945.GB22336@uio.no>
	<Pine.LNX.4.58.0504051957560.1851@donald.themaw.net>
	<20050405123425.GA20348@uio.no>
	<Pine.LNX.4.58.0504060958150.24274@wombat.indigo.net.au>
	<42543F39.3030105@rhythm.com>
	<Pine.LNX.4.58.0504071025550.24138@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504071025550.24138@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org



Ian Kent wrote:

>On Wed, 6 Apr 2005, Greg Bradner wrote:
>
>  
>
>>I have a situation on IRIX where I am stat'ing a filesystem that is not 
>>exported to the IRIX system.  The syslog says 'permission denied'.  
>>That's expected.  Since the directory I'm in has 600 links to the file 
>>system that is not exported, autofs keeps trying to mount and keeps 
>>getting 'permission denied'.
>>
>>On linux I get 'permission denied', but it doesn't try to mount again 
>>for 30 minutes.
>>
>>Has anyone heard of such a problem with IRIX's autofs and is there a fix?
>>Why does linux only try every 30 minutes?
>>    
>>
>
>I'm not sure why Linux is trying every thirty minutes.
>There's not explicit retry login in autofs.
>
>AFAIK it should only try to mount the target of the symlink when an access 
>is attempted.
>
>Ian
>  
>
Let me explain: I have one NAS1 server that has a large number of links 
to another NAS2.  When I run a specific program, an in house tool, it 
stats the links; which in turn tries to mount NAS2.  With the large 
number of links, the program will stat one, get 'permission denied', and 
moves to the next.  On IRIX, autofs tries to mount with each stat.  On 
linux, it stats the link, but doesn't try to mount each time, rather 
every 30 minutes.
My main curiosity is whether or not Linux autofs caches the status in 
some way and won't retry for 30 minutes?

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com
