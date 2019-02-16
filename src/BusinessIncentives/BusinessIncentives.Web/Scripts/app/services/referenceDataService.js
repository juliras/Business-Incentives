angular.module('businessIncentivesApp')
    .service('referenceDataService', ['$http', function ($http) {

        var businessTypes = [
            { name: 'New', type: 'New' },
            { name: 'Existing', type: 'Existing' },
            { name: 'Relocating', type: 'Relocating' }
        ];
        var industries = [
            { label: 'Affordable Care Act', id: 1 },
            { label: 'Agriculture', id: 2 },
            { label: 'Arts/Cultural Affairs', id: 3 },
            { label: 'Business and Commerce', id: 4 },
            { label: 'Community Development', id: 5 },
            { label: 'Consumer Protection', id: 6 },
            { label: 'Disaster Prevention and Relief', id: 7 },
            { label: 'Education', id: 8 },
            { label: 'Employment, Labor and Training', id: 9 },
            { label: 'Energy', id: 10 },
            { label: 'Environment', id: 11 },
            { label: 'Food and Nutrition', id: 12 },
            { label: 'Health', id: 13 },
            { label: 'Housing', id: 14 },
            { label: 'Humanities', id: 15 },
            { label: 'Income Security and Social Services', id: 16 },
            { label: 'Information and Statistics', id: 17 },
            { label: 'Law, Justice and Legal Services', id: 18 },
            { label: 'Natural Resources', id: 19 },
            { label: 'Recovery Act', id: 20 },
            { label: 'Regional Development', id: 21 },
            { label: 'Science and Technology and other Research and Development', id: 22 },
            { label: 'Transportation', id: 23 },
            { label: 'Other', id: 24 }
        ];
        var assistanceTypes = [
                { label: 'Advisory Service', id: 1 },
                { label: 'Cash', id: 2 },
                { label: 'Equipment Assistance', id: 3 },
                { label: 'Grant', id: 4 },
                { label: 'Loan', id: 5 },
                { label: 'Other', id: 6 },
                { label: 'Specialized Service', id: 7 },
                { label: 'Tax Incentive', id: 8 },
                { label: 'Training', id: 9 },
                { label: 'Venture Capital', id: 10 }

        ];
        var businessAttributes = [
            { label: 'Minority', id: 1 },
            { label: 'Nonprofit', id: 2 },
            { label: 'Nonprofit 501c3', id: 3 },
            { label: 'Small Business', id: 4 },
            { label: 'Veteran', id: 5 },
            { label: 'Woman owned', id: 6 }
        ];

        var fundingLevels = [
            { label: 'City', id: 1 },
            { label: 'State', id: 2 },
            { label: 'County', id: 3 },
            { label: 'Region', id: 4 },
            { label: 'Federal', id: 5 }
        ];

        return {
            businessTypes: businessTypes,
            industries: industries,
            assistanceTypes: assistanceTypes,
            fundingLevels: fundingLevels,
            businessAttributes: businessAttributes
        };
    }]);
