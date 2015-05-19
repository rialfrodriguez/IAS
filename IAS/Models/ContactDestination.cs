using System;
using System.Collections.Generic;

namespace IAS.Models
{
    public partial class ContactDestination
    {
        public ContactDestination()
        {
            this.ClaimContactHistories = new List<ClaimContactHistory>();
            this.ClaimContactHistory1 = new List<ClaimContactHistory1>();
        }

        public short ContactDestinationID { get; set; }
        public string Description { get; set; }
        public bool Active { get; set; }
        public virtual ICollection<ClaimContactHistory> ClaimContactHistories { get; set; }
        public virtual ICollection<ClaimContactHistory1> ClaimContactHistory1 { get; set; }
    }
}
