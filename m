From: Tom Georgoulias <tom.georgoulias@motorola.com>
Subject: Re: autofs reload
Date: Mon, 29 Mar 2004 09:17:48 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40683E1C.7030202@motorola.com>
References: <200403270053.i2R0rUt3013696@miguelito.qualcomm.com>
	<Pine.LNX.4.58.0403290957560.22486@vulture.rentec.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403290957560.22486@vulture.rentec.com>
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
To: autofs@linux.kernel.org

Ryan Go wrote:

>>BTW, doing that with 4.0.0 (is anyone still running it?) it'll just kill the
>>daemon.  Found that out the hard way. :-/
> 
> 
> Yeap. We still are. 4.0.0pre10-x (at least SuSe's version).

I had considered reverting back to the 4.0.0pre10 version many times 
because it doesn't require me to manually HUP daemons to put map updates 
into effect. Now that some patches are showing up my reversion 
tendencies are reducing.  ;)

I'm glad to see Jeff Moyer posting to the list and submitting patches. 
Good to know that Red Hat is listening to its customers who need more 
than autofs v3.

Tom
-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Motorola Internal Use
[] Motorola Confidential Proprietary
