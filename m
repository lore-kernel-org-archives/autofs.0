From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: compatibility with solaris '[no]browse' mount option
Date: Mon, 14 Jun 2004 14:48:25 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40CE1D29.9070205@sedona.intel.com>
References: <16589.63971.33237.4865@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16589.63971.33237.4865@segfault.boston.redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:

>Hello,
>
>I've currently got a request to support the browse mount option.  It seems
>do-able entirely in the init script (and this seems the right place).
>Would there be any objections to such an approach?
>  
>
Best I recall, browse is the same thing as ghosting - correct?

Is browsing/ghosting an all on or all off scenario?  Ie, could you have 
a submap that has ghosting on but not for others?  If so, I don't think 
you can handle it in the startup script.  In this case, I think we would 
have to handle it in the parsing of the maps.

Otherwise, I think it could be handled in the startup script.

I have often wondered about ghosting = browsing and handling this as well.

Michael

Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.
