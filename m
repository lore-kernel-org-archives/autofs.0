From: ramana <ramana@intraperson.com>
Subject: Re: Autofs 4.1.4_beta2 + NetApp Filer + missing dir
Date: Sat, 05 Mar 2005 08:44:21 +0530
Message-ID: <4229240D.5090203@intraperson.com>
References: <200503050107.j2517EGK021770@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503050107.j2517EGK021770@cornholio.qualcomm.com>
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
To: mmarion@qualcomm.com
Cc: autofs@linux.kernel.org

mmarion@qualcomm.com wrote:
> On  1 Mar, devnull@adc.idt.com wrote:
> 
> 
>>This is an extension to the "unacceptable bug in autofs kernel module" 
>>sent by mmarion at qualcomm
> 
> 
> I didn't send that.. someone else did, but I did comment that I thought we
> were seeing the same thing.  I try to be more subtle when talking about a 
> bug.. especially when I know I can't code well enough to fix it. :)
> 
> 
I try to be this way.


> That problem almost seems like the programs expect the mount to be atomic, and
> error out before automount has a time to do it's mount.. even though it's
> sub-second in it's action.
> 

No.



Regards
ramana

-- 
http://www.intraperson.com
