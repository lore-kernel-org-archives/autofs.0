From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: Autofs picking first server from the automounter map
 all the time
Date: Fri, 30 Apr 2004 13:52:13 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4092BC7D.2080703@sedona.intel.com>
References: <D85B695BF793684EA72C8E481FB1D9A1225096@nycmgexm004.leh.lbcorp.lehman.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <D85B695BF793684EA72C8E481FB1D9A1225096@nycmgexm004.leh.lbcorp.lehman.com>
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
To: "Patel, Rahulkumar [NJ]" <rahul@lehman.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

Patel, Rahulkumar [NJ] wrote:

>Hi,
>I have following entry defined in the automounter map.
>But, when I try to access it all the time it pick last server defined for
>that mount.
>
>perl -ro,soft,nosuid,noquota,intr server1:/vol/vol1/software/perl
>server2:/vol/vol1/software/perl.
>
>
>When I cd /home/perl --> All the time I connect to server2.
>
>I am running autofs-3.1.7-21.
>  
>
Autofs 3.x and autofs 4.0.x didn't have real support for replicated 
server.  It simply picks the first server in the list.

Autofs 4.1.x does include support for replicated server.  You should 
upgrade and test.

Michael


Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.
